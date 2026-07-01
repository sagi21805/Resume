#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  accent-color: "#000000",
  font: "New Computer Modern",
  paper: "us-letter",
  author-font-size: 20pt,
  font-size: 10pt,
  body,
) = {
  // Sets document metadata
  set document(author: author, title: author)

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: font-size,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false,
  )

  // Recommended to have 0.5in margin on all sides
  set page(
    margin: 0.5in,
    paper: paper,
  )

  // Link styles
  show link: underline

  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: author-font-size,
    )
    #pad(it.body)
  ]

  // Level 1 Heading
  [= #(author)]

  // Personal Info Helper
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  // Personal Info
  pad(
    top: 0.25em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(pronouns),
          contact-item(phone),
          contact-item(location),
          contact-item(email, link-type: "mailto:"),
          contact-item(github, link-type: "https://"),
          contact-item(linkedin, link-type: "https://"),
          contact-item(personal-site, link-type: "https://"),
        )
        items.filter(x => x != none).join("  |  ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature because ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

#let work(
  title: "",
  dates: "",
  company: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: emph(company),
    bottom-right: emph(location),
  )
}

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
  site: "",
) = {
  generic-one-by-two(
    left: {
      if role == "" {
        [*#name* #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      } else {
        [*#role*, #name #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      }
      if site != "" {
        linebreak()
        text(size: 0.85em, style: "italic")[#link("https://" + site)[#site]]
      }
    },
    right: {
      if dates == "" and url != "" {
        link("https://" + url)[#url]
      } else {
        dates
      }
    },
  )
}
#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = {
  [
    *#name*, #emph(issuer)
    #if url != "" {
      [ (#link("https://" + url)[#url])]
    }
    #h(1fr) #date
  ]
}

#show: resume.with(
  author: "Sagi Or",
  email: "sagi21805@gmail.com",
  github: "github.com/sagi21805",
  phone: "(+972) 58-499-9162",
  linkedin: "linkedin.com/in/sagi-or-2602101a6",
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: center,
  personal-info-position: center,
)

== Profile

Software Engineer with 4+ years of experience in creating and maintaining custom open source projects. Proficient in Rust and Python with hands on experience on developing low level software like drivers and operating systems.

Passionate about writing clean and optimized code, learning new things, and understanding complex problems to their core.

== Experience
#work(
  title: "Storage & Virtualization Engineer",
  location: "Rishon Lezion, Israel",
  company: "IDF - Genesis",
  dates: dates-helper(start-date: "Mar 2024", end-date: "Feb 2027"),
)

- Developed custom software for Dell Isilon to allow data retention with custom logic provided as external Python code.
- Developed infrastructure automations for both Dell Isilon and ECS as well as VMware vSphere and ESXi.
- Maintained 15+ virtualization and storage clusters.
- Architected load balancing solution for a massive S3 storage system.

#work(
  title: "Junior Software Engineer",
  location: "Rehovot, Israel",
  company: "Nano Dimensions",
  dates: dates-helper(start-date: "Jun 2023", end-date: "Nov 2023"),
)

- Developed custom Python image processing software to measure 3D prints dimensions from a microscope image, drastically improving feedback time.

#work(
  title: "FRC Team Member & Captain",
  location: "Ness Ziona, Israel",
  company: "Demacia 5635",
  dates: dates-helper(start-date: "Jul 2020", end-date: "Mar 2023"),
)

- Gained experience in electronics, and mechanics while building robots that could shoot a ball into a basket, or put a cone on a pole.
- On my senior year, I was the team captain leading the team to the world championship competition in Huston Texas, after 6 year since the last time.

== Projects
#project(
  name: "LearnixOS",
  url: "github.com/sagi21805/LearnixOS",
)

Created a custom operating system from scratch in Rust for x86_64 CPU. This operating system has a functional booting into long mode, printing to screen using VGA, memory allocation for pages using Buddy allocation and object allocation using Slab allocation, hardware interrupts using the PIC8259, a working keyboard driver, synchronization primitives like RwLock and Mutex, and an on development AHCI disk driver.

As of the 1st of July 2026, this repository has 269 stars of GitHub.

#project(
  name: "LearnixOS book",
  url: "learnix-os.com",
)

Created a book with custom syntax highlighting explaining step by step the development of the Learnix Operating System and advanced Rust topics like custom Rust compilation targets, and Procedural Macros. Created this book because there was no good source about OS development in Rust, so I decided to create one.

#project(
  name: "Tracker",
  url: "github.com/sagi21805/tracker",
)

Created custom tracker that follows FRC robots during a match record for automatic analytics on robot performance during the match. The robot recognition was done using custom YOLO model, and the tracking and following was done with custom logic that could predict future robot locations, and fixing errors due to imperfect detection model.

#project(
  name: "Matmul NPU",
  url: "github.com/sagi21805/matmul-npu",
)

Created a driver that uses the internal function on the Neural Processing Unit that is on the RK3588 chip to create fast matrix multiplication using hardware.

As of the time of writing, this repository has 17 stars on GitHub.

#project(
  name: "mdbook-rust-analyzer-highlight",
  url: "github.com/sagi21805/mdbook-rust-analyzer-highlight",
)

Custom syntax highlighter for the LearnixOS book that uses Rust Analyzer to process a project, and then gives the ability to include items from the project files like functions, impl blocks,  structs and more.

== Skills
- Programming Languages - Rust, Python, Bash, C/C++
