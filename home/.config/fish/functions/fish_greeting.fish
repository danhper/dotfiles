function fish_greeting
    if command -s flashcards > /dev/null 2>&1
        flashcards show -random
    end
end
