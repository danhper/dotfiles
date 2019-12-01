function fish_greeting
    if test -z "$DISABLE_FLASHCARDS" && command -s flashcards > /dev/null 2>&1
        flashcards show -random
    end
end
