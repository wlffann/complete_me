Shoes.app do
  blueviolet = rgb(142, 102, 255)
  darkgreen = rgb(170, 58, 255)
  background gradient(blueviolet, darkgreen)
  suggestions = ["pizza", "pizzeria", "pizzaz"]
  # string = ask("type a string")

  para "Choose a word:"
  list_box items: suggestions
 end
