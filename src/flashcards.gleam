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
  ShowAnswer
}

type Model{
  Model(cards: List(Card), show_answer: Bool)
}

fn init(_flags) {
  Model(cards: [
    Card("What is the capital of France?", "Paris"),
    Card("What is 2 + 2?", "4"),
    Card("Who wrote Hamlet?", "William Shakespeare"),
  ], show_answer: False)
}

fn display_card(card: Card, show_answer: Bool) {
    div([], [

      case show_answer {
        True -> h1([], [
          element.text(card.back), 
          button([on_click(AnsweredCorrectly)], [element.text(" ✅ ")]),
          button([on_click(AnsweredWrongly)], [element.text(" ❌ ")]),
        ])
        False -> div([], [
      h1([], [element.text(card.front)]),
          button([on_click(ShowAnswer)], [element.text("Show answer")]),
        ])
      }
    ])
}

fn display_end() {
    div([], [
      h1([], [element.text("Well done!")]),
    ])
}

fn update(model: Model, msg: Msg) {
  case msg {
    AnsweredCorrectly -> Model( model.cards |>list.drop(1), False)
    AnsweredWrongly -> Model( model.cards |>list.drop(1), False)
    ShowAnswer -> Model( model.cards, True)
  }
}

fn view(model: Model){
  case model.cards {
    [first, .. ] -> display_card(first, model.show_answer)
    [] -> display_end() 
  }
}

pub fn main() {

  let app = lustre.simple(init, update, view)

  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}