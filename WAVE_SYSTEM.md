# Wave System Documentation

## 5-Level Wave Progression

The game now features a properly structured 5-level wave system with progressive difficulty:

### Wave Level 1 - "Introduction"

- **Enemies**: 8 Basic enemies
- **Spawn Rate**: 1.2 seconds between spawns
- **Difficulty**: Easy - introduces basic gameplay
- **Total Enemies**: 8

### Wave Level 2 - "Mixed Assault"

- **Enemies**: 10 Basic + 3 Fast enemies
- **Spawn Rate**: 1.0 seconds between spawns
- **Difficulty**: Easy-Medium - introduces fast enemies
- **Total Enemies**: 13

### Wave Level 3 - "Tank Introduction"

- **Enemies**: 8 Basic + 5 Fast + 2 Tank enemies
- **Spawn Rate**: 0.8 seconds between spawns
- **Difficulty**: Medium - introduces tank enemies
- **Total Enemies**: 15

### Wave Level 4 - "All Out War"

- **Enemies**: 6 Basic + 8 Fast + 4 Tank + 3 Armored + 4 Flying enemies
- **Spawn Rate**: 0.6 seconds between spawns
- **Difficulty**: Hard - all enemy types except boss
- **Total Enemies**: 25

### Wave Level 5 - "Final Boss"

- **Enemies**: 8 Basic + 6 Fast + 5 Tank + 4 Armored + 5 Flying + 1 Boss enemy
- **Spawn Rate**: 0.5 seconds between spawns
- **Difficulty**: Very Hard - includes boss enemy
- **Total Enemies**: 29

## Enemy Type Distribution

| Wave | Basic | Fast | Tank | Armored | Flying | Boss | Total |
| ---- | ----- | ---- | ---- | ------- | ------ | ---- | ----- |
| 1    | 8     | 0    | 0    | 0       | 0      | 0    | 8     |
| 2    | 10    | 3    | 0    | 0       | 0      | 0    | 13    |
| 3    | 8     | 5    | 2    | 0       | 0      | 0    | 15    |
| 4    | 6     | 8    | 4    | 3       | 4      | 0    | 25    |
| 5    | 8     | 6    | 5    | 4       | 5      | 1    | 29    |

## Spawn Weight System

Each enemy type has a spawn weight that affects the likelihood of spawning:

- **Higher weight** = more likely to spawn early in the wave
- **Lower weight** = more likely to spawn later in the wave

### Weight Distribution by Wave:

- **Wave 1**: Basic (1.0)
- **Wave 2**: Basic (2.0), Fast (1.0)
- **Wave 3**: Basic (2.0), Fast (1.5), Tank (0.8)
- **Wave 4**: Basic (1.5), Fast (2.0), Tank (1.2), Armored (1.0), Flying (1.8)
- **Wave 5**: Basic (1.5), Fast (1.8), Tank (1.2), Armored (1.0), Flying (1.5), Boss (0.3)

## Technical Implementation

### Files Created:

- `wave_level_1.tres` - Level 1 wave configuration
- `wave_level_2.tres` - Level 2 wave configuration
- `wave_level_3.tres` - Level 3 wave configuration
- `wave_level_4.tres` - Level 4 wave configuration
- `wave_level_5.tres` - Level 5 wave configuration

### Enhanced System Features:

- **Enemy Type Integration**: Each wave entry specifies which enemy type to spawn
- **Single Scene System**: All waves use the single `enemy.tscn` but configure it with different types
- **Progressive Difficulty**: Each wave increases in complexity and enemy count
- **Spawn Rate Acceleration**: Time between spawns decreases with each wave
- **Balanced Variety**: Good mix of enemy types with strategic spawn weights

### Usage in Game:

The wave manager will automatically progress through these 5 levels, spawning the appropriate enemy types with the correct configurations. The EnemyFactory system ensures each enemy is properly configured with the right stats, appearance, and resistances.
