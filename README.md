# Light When Shooting

_**English** | [Русский](README.ru.md)_

AMX Mod X plugin for Counter-Strike.

The plugin adds a light effect (small aura) when firing a weapon. When firing with a silencer, the aura is significantly less.

## Configuration
The configuration is done in the source file:
```c
const LightRadius = 20	// Radius of light
const LightR = 255	 // RGB Red
const LightG = 155	 // RGB Green
const LightB = 55	 // RGB Blue
const LightLife = 8	 // Time before the light disappears
const LightDecay = 60	// Light fading
```

## Authors
- [Chrescoe1](https://github.com/Chrescoe1)
