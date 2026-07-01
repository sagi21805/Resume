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

Software Engineer with 4+ years of experience building and maintaining open source projects, specializing in low level programming (drivers, OS) in Rust and infrastructure automation in Python.

== Experience
#work(
  title: "Storage & Virtualization Engineer",
  location: "Rishon Lezion, Israel",
  company: "IDF - Genesis",
  dates: dates-helper(start-date: "Mar 2024", end-date: "Present"),
)

- Developed custom tooling for Dell Isilon enabling data retention via external Python code.
- Built infrastructure automation for Dell Isilon, ECS, VMware vSphere, and ESXi.
- Maintained 15+ virtualization and storage clusters.
- Architected a load balancing solution for a massive S3 storage system.

#work(
  title: "Junior Software Engineer",
  location: "Rehovot, Israel",
  company: "Nano Dimensions",
  dates: dates-helper(start-date: "Jun 2023", end-date: "Nov 2023"),
)

- Built Python image processing software to measure 3D print dimensions from microscope images, drastically improving feedback time.

#work(
  title: "FRC Team Member & Captain",
  location: "Ness Ziona, Israel",
  company: "Demacia 5635",
  dates: dates-helper(start-date: "Jul 2020", end-date: "Mar 2023"),
)

- Built FRC competition robots, gaining hands-on experience in electronics and mechanics.
- Team captain in senior year. Led the team to the World Championship in Houston Texas. Its second qualification in 9 years.

== Projects
#project(
  name: "LearnixOS",
  url: "github.com/sagi21805/LearnixOS",
)

Custom x86_64 operating system in Rust featuring long mode boot, VGA display, Buddy/Slab memory allocation, PIC8259 interrupts, keyboard driver, RwLock/Mutex synchronization primitives, and an in development AHCI disk driver.

265+ GitHub stars. Reached top 10 on Hacker News twice.

#project(
  name: "LearnixOS book",
  url: "learnix-os.com",
)

Wrote a step by step book on building OS in Rust while also explaining advanced Rust topics like custom compilation targets, procedural macros. Filling a gap in Rust OSdev resources. Built a custom #link("https://github.com/sagi21805/mdbook-rust-analyzer-highlight")[syntax highlighter] to include highlighted code directly from the source code.

#project(
  name: "Tracker",
  url: "github.com/sagi21805/tracker",
)

Built a tracker that follows FRC robots during matches for automated analytics, using a custom YOLO model for detection and custom logic to predict robot future positions while handling detection errors on the model.

#project(
  name: "Matmul NPU",
  url: "github.com/sagi21805/matmul-npu",
)

Driver written in C++ using the RK3588 NPU's builtin matrix multiplication unit to accelerate matrix multiplication in hardware, bypassing the CPU/GPU.  17 GitHub stars.

== Skills
- *Languages:* Rust, Python, Bash, C/C++
- *Systems & Low-Level:* OS development, custom memory allocators (Buddy/Slab), interrupt handling, disk drivers (AHCI), synchronization primitives
- *Networking:* Networking protocols such as HTTP/S, TCP, UDP, Ethernet etc.
- *Infrastructure & Virtualization:* VMware vSphere/ESXi, Dell Isilon, Dell ECS, S3, infrastructure automation
- *ML/CV:* YOLO  object detection, custom model training
