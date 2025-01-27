import gleam/list
import lustre
import lustre/element
import lustre/element/html.{div, h1, ul, li}

pub type Card {
  Card(front: String, back: String)
}

fn display_card(card: Card) {
    div([], [
      h1([], [element.text(card.front)]),
    ])
}

fn display_end() {
    div([], [
      h1([], [element.text("Well done!")]),
    ])
}

pub fn main() {
  let cards = [
    Card("What is the capital of France?", "Paris"),
    Card("What is 2 + 2?", "4"),
    Card("Who wrote Hamlet?", "William Shakespeare"),
  ]

let e = case cards {
[current_card, ..] -> display_card(current_card)
[] -> display_end()
}

  let app = lustre.element(e)

  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}