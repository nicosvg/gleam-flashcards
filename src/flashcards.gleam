import gleam/list
import lustre
import lustre/element
import lustre/element/html.{div, h1, button}
import lustre/event.{on_click}

pub type Card {
  Card(front: String, back: String)
}

type Msg {
  AnsweredCorrectly
  AnsweredWrongly
}

type Model{
  Model(cards: List(Card))
}

fn init(_flags) {
  Model(cards: [
    Card("What is the capital of France?", "Paris"),
    Card("What is 2 + 2?", "4"),
    Card("Who wrote Hamlet?", "William Shakespeare"),
  ])
}

fn display_card(card: Card) {
    div([], [

      h1([], [element.text(card.front)]),
          button([on_click(AnsweredCorrectly)], [element.text(" ✅ ")]),
          button([on_click(AnsweredWrongly)], [element.text(" ❌ ")]),
    ])
}

fn display_end() {
    div([], [
      h1([], [element.text("Well done!")]),
    ])
}

fn update(model: Model, msg) {
  case msg {
    AnsweredCorrectly -> Model( model.cards |>list.drop(1))
    AnsweredWrongly -> Model( model.cards |>list.drop(1))
  }
}


fn view(model: Model){
  case model.cards {
    [first, .. ] -> display_card(first)
    [] -> display_end() 
  }
}

pub fn main() {

  let app = lustre.simple(init, update, view)

  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}