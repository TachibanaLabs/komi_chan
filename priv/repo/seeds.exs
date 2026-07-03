alias KomiChan.Repo
alias KomiChan.Boards.Board
alias KomiChan.Threads.Thread
alias KomiChan.Posts.Post

# Clean existing data
Repo.delete_all(Post)
Repo.delete_all(Thread)
Repo.delete_all(Board)

# Create boards
{:ok, anime} =
  %Board{}
  |> Board.changeset(%{name: "Anime & Manga"})
  |> Repo.insert()

{:ok, technology} =
  %Board{}
  |> Board.changeset(%{name: "Technology"})
  |> Repo.insert()

{:ok, random} =
  %Board{}
  |> Board.changeset(%{name: "Random"})
  |> Repo.insert()

# Create threads
{:ok, thread1} =
  %Thread{}
  |> Thread.changeset(%{title: "Best anime of 2026?", sticky: false, board_id: anime.id})
  |> Repo.insert()

{:ok, thread2} =
  %Thread{}
  |> Thread.changeset(%{title: "Welcome to /a/ - Rules & FAQ", sticky: true, board_id: anime.id})
  |> Repo.insert()

{:ok, thread3} =
  %Thread{}
  |> Thread.changeset(%{
    title: "What programming language should I learn?",
    sticky: false,
    board_id: technology.id
  })
  |> Repo.insert()

{:ok, thread4} =
  %Thread{}
  |> Thread.changeset(%{
    title: "Linux vs Windows for development",
    sticky: false,
    board_id: technology.id
  })
  |> Repo.insert()

{:ok, thread5} =
  %Thread{}
  |> Thread.changeset(%{
    title: "Elixir and Phoenix appreciation thread",
    sticky: true,
    board_id: technology.id
  })
  |> Repo.insert()

{:ok, thread6} =
  %Thread{}
  |> Thread.changeset(%{title: "Post your favorite memes", sticky: false, board_id: random.id})
  |> Repo.insert()

# Create posts
Repo.insert!(%Post{
  name: "Anonymous",
  subject: "Best anime of 2026?",
  text: "I think Frieren season 2 is going to be incredible. Anyone else hyped?",
  thread_id: thread1.id
})

Repo.insert!(%Post{
  name: "OtakuFan",
  subject: "Re: Best anime of 2026?",
  text: "Definitely Frieren. The manga is already peak fiction.",
  thread_id: thread1.id
})

Repo.insert!(%Post{
  name: "Admin",
  subject: "Rules & FAQ",
  text:
    "1. Be respectful\n2. No spoilers without tags\n3. All posts must be anime/manga related\n4. Have fun!",
  thread_id: thread2.id
})

Repo.insert!(%Post{
  name: "Newbie",
  subject: "What programming language should I learn?",
  text: "I'm just starting out. Should I learn Python or JavaScript first?",
  thread_id: thread3.id
})

Repo.insert!(%Post{
  name: "DevGuru",
  subject: "Re: What programming language should I learn?",
  text:
    "Start with Python for fundamentals, then learn JS for web. Or just learn Elixir and skip the pain!",
  thread_id: thread3.id
})

Repo.insert!(%Post{
  name: "LinuxFan",
  subject: "Linux vs Windows for development",
  text:
    "Linux is objectively better for development. Docker, package managers, native terminal — it just works.",
  thread_id: thread4.id
})

Repo.insert!(%Post{
  name: "ElixirFan",
  subject: "Elixir and Phoenix appreciation thread",
  text:
    "Just wanted to say: Elixir + Phoenix is the most productive stack I've ever used. Supervisors, pattern matching, LiveView... it's incredible.",
  thread_id: thread5.id
})

Repo.insert!(%Post{
  name: "MemeLord",
  subject: "Post your favorite memes",
  text: "> be me\n> write a post on KomiChan\n> nobody replies\n> mfw.jpg",
  thread_id: thread6.id
})
