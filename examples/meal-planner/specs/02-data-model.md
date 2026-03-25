# Data Model

## Meal

- `id`
- `date`
- `meal_type` (`breakfast` | `lunch` | `dinner`)
- `recipe_id`
- `servings`
- `notes`

## Recipe

- `id`
- `title`
- `ingredients[]`
- `steps[]`
- `tags[]`
- `prep_time_minutes`

## Pantry Item

- `id`
- `name`
- `quantity`
- `unit`
- `expires_at`

## Grocery List Item

- `id`
- `name`
- `quantity`
- `unit`
- `checked`

## Invariants

- Grocery items are derived from planned meals minus pantry inventory.
- A meal must always reference either a valid recipe or a manual note-based meal entry.
