module GreetingsHelper
  def greetings
    values = ["night", "morning", "afternoon", "evening"].map { |value| t("greetings.#{value}") }

    tag.span("", data: {
      controller: "greetings",
      greetings_target: "timedResponse", greetings_greetings_value: values
    })
  end
end
