#!/usr/bin/env bash
#
# Claude Code status line script
# Shows: random anime quote

# --- Random anime quote (cached for 300s) ---
anime_quotes=(
    "Believe in the me that believes in you. - Kamina (Gurren Lagann)"
    "If you don't take risks, you can't create a future. - Luffy (One Piece)"
    "A lesson without pain is meaningless. - Edward Elric (FMA: Brotherhood)"
    "The world isn't perfect. But it's there for us, trying the best it can. - Roy Mustang (FMA: Brotherhood)"
    "People's lives don't end when they die. It ends when they lose faith. - Itachi (Naruto Shippuden)"
    "Fear is not evil. It tells you what your weakness is. - Gildarts (Fairy Tail)"
    "Whatever you lose, you'll find it again. But what you throw away you'll never get back. - Kenshin (Rurouni Kenshin)"
    "If you don't like your destiny, don't accept it. - Naruto (Naruto)"
    "Power comes in response to a need, not a desire. - Goku (Dragon Ball Z)"
    "The only thing we're allowed to do is believe we won't regret the choice we made. - Levi (Attack on Titan)"
    "You should enjoy the little detours to the fullest. That's where you'll find things more important than what you want. - Ging (Hunter x Hunter)"
    "Giving up kills people. When people reject giving up, they finally win the right to transcend humanity. - Alucard (Hellsing)"
    "Being weak is nothing to be ashamed of. Staying weak is. - Fuegoleon (Black Clover)"
    "Reject common sense to make the impossible possible. - Simon (Gurren Lagann)"
    "A dropout will beat a genius through hard work. - Rock Lee (Naruto)"
    "The moment you think of giving up, think of the reason why you held on so long. - Natsu (Fairy Tail)"
    "I'll leave tomorrow's problems to tomorrow's me. - Saitama (One Punch Man)"
    "When do you think people die? When they are forgotten. - Dr. Hiluluk (One Piece)"
    "In this world, wherever there is light, there are always shadows. - Madara (Naruto Shippuden)"
    "Life is not a game of luck. If you wanna win, work hard. - Sora (No Game No Life)"
    "Simplicity is the easiest path to true beauty. - Seishuu (Barakamon)"
    "We don't have to know what tomorrow holds. That's why we can live for everything we're worth today. - Natsu (Fairy Tail)"
    "The night is darkest before the dawn. But keep your eyes open. If you avert your eyes from the dark, you'll be blind to the light. - Kakashi (Naruto)"
    "It's not about whether you get knocked down. It's about whether you get back up. - Vash (Trigun)"
    "Those who stand at the top determine what's wrong and what's right. - Sousuke Aizen (Bleach)"
    "Even if I can't see you, I'll always be watching over you. - Makarov (Fairy Tail)"
    "There's no shame in falling down. True shame is not standing up again. - Midoriya (My Hero Academia)"
    "The ticket to the future is always open. - Vash (Trigun)"
    "Sometimes I do feel like I'm a failure. Like there's no hope for me. But even so, I'm not gonna give up. - Izuku (My Hero Academia)"
    "A person grows up when he's able to overcome hardships. - Jiraiya (Naruto)"
)

now=$(date +%s)
quote_cache="/tmp/.anime_quote_cache"
quote_refresh=0
if [ -f "$quote_cache" ]; then
    quote_age=$(( now - $(stat -f %m "$quote_cache" 2>/dev/null || stat -c %Y "$quote_cache" 2>/dev/null) ))
    [ "$quote_age" -ge 300 ] && quote_refresh=1
else
    quote_refresh=1
fi

if [ "$quote_refresh" -eq 1 ]; then
    quote_index=$(( RANDOM % ${#anime_quotes[@]} ))
    quote="${anime_quotes[$quote_index]}"
    printf "%s" "$quote" > "$quote_cache"
else
    quote=$(cat "$quote_cache" 2>/dev/null)
fi

quote_line1=$(printf "%s" "$quote" | cut -c1-90)
quote_line2=""
if [ ${#quote} -gt 90 ]; then
    quote_line1=$(printf "%.90s" "$quote" | sed 's/ [^ ]*$//')
    quote_line2=${quote:${#quote_line1}}
    quote_line2=$(printf "%s" "$quote_line2" | sed 's/^ //')
fi
printf "%s" "$quote_line1"
[ -n "$quote_line2" ] && printf "\n%s" "$quote_line2"
