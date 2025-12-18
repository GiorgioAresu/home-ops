# LLMs

Without bothering to spend too much time to validate, this is Claude 3.5 Sonnet suggestion as of Dec 2025 on what models to run. Keeping this as a reference more than anything else.

## Quick notes:

Without specifying a quantization, Ollama typically pulls Q4_0 or similar by default
 - `q4_K_M` is a good balance of quality and speed
 - `q5_K_M` is slightly better quality but slower
 - `q4_0` is faster but slightly lower quality than `q4_K_M`

## Core i5 1340P with 64GB RAM

### Best Overall Options:

- Llama 3.2 3B - Excellent balance of performance and speed. The quantized versions (Q4 or Q5) will run smoothly on your CPU and provide surprisingly good quality for its size.

- Phi-3.5 Mini (3.8B) - Microsoft's model punches above its weight class. Very efficient and surprisingly capable for coding and reasoning tasks.

- Gemma 2 2B or 9B - Google's models are well-optimized. The 2B will be very fast, while the 9B quantized (Q4) should still run reasonably well on your 64GB RAM.

#### Practical Considerations:

With 64GB RAM, you can actually run larger models than most CPU-only setups. A quantized Llama 3.1 8B (Q4 or Q5) would work well and give you noticeably better quality than the smaller models.

For the best experience, I'd recommend using Ollama or LM Studio as your interface - both make it easy to download and run models with good CPU optimization.

Speed vs Quality Trade-off:

 - Fast responses: 2-3B models (near-instant)
 - Good balance: 7-8B quantized models (a few seconds per response)
 - Best quality you can reasonably run: 13B quantized (slower but manageable)

Your P-cores on the 1340P will do most of the heavy lifting, and 64GB RAM means you won't be constrained by memory. Start with Llama 3.2 3B or Phi-3.5 to get a feel for local LLMs, then experiment with larger quantized models if you want better quality.

```bash
ollama pull llama3.2:3b
ollama pull phi3.5:3.8b
ollama pull gemma2:2b
```

#### Balanced options (recommended starting point):

```bash
ollama pull llama3.2:3b-instruct-q4_K_M
ollama pull gemma2:9b-instruct-q4_K_M
```

#### Larger models for better quality:

```bash
ollama pull llama3.1:8b-instruct-q4_K_M
ollama pull llama3.1:8b-instruct-q5_K_M
```

### Tool-Capable Models:

 - Llama 3.2 3B and Llama 3.1 8B both support tool/function calling natively. The 8B version is noticeably better at complex tool use. These work well with frameworks like Ollama that support their tool use format.
 - Hermes 3 (based on Llama, various sizes) - specifically fine-tuned for function calling and structured outputs. The 8B version would run well on your system.
 - Mistral 7B and its variants have decent tool use capabilities, though Llama 3.1 generally performs better for this.

### Image generation

Really needs a decent GPU. Stable Diffusion 1.5 or SDXL-Turbo technically can run on CPU, but generation times would be measured in minutes (or 10+ minutes) per image rather than seconds
They're also heavily optimized for GPU parallel processing, so CPU performance is quite poor. iGPU doesn't really help.

#### Realistic Options:

 - Cloud APIs (OpenAI's DALL-E, Stability AI, Midjourney)
 - ComfyUI or Automatic1111 with very long generation times as a learning exercise
 - Consider using services like Replicate or Together AI that offer affordable per-image pricing


## Core Ultra 125H with low memory

Some suggestions for models to run on a Core Ultra 125H with as little memory as possible

### General use

#### Ultra-light models (1-2GB RAM)

```bash
ollama pull qwen2.5:0.5b
ollama pull qwen2.5:1.5b
ollama pull phi3.5:3.8b-mini-instruct-q4_0
```

#### Small but capable (2-3GB RAM)

```bash
ollama pull llama3.2:1b
ollama pull gemma2:2b-instruct-q4_0
ollama pull tinyllama:1.1b
```

#### If you can spare ~4GB

```bash
ollama pull llama3.2:3b-instruct-q4_0
ollama pull phi3.5:3.8b
```

### Best tool-capable small models

```bash
ollama pull llama3.2:3b-instruct-q4_0  # Native tool support
ollama pull qwen2.5:3b-instruct-q4_0   # Good function calling
ollama pull qwen2.5:7b-instruct-q4_0   # Better tools, still ~4.5GB RAM
ollama pull mistral:7b-instruct-q4_0   # Solid tool support
```

#### Newer options


```bash
ollama pull hermes3:8b-llama3.1-q4_0   # Specifically fine-tuned for tools
```

### Image generation

Not at this size:

 - Stable Diffusion (smallest practical): ~3-4GB minimum, requires significant compute
 - SDXL: 6-8GB+
 - Flux: 12GB+

### Image analysis

```bash
ollama pull llama3.2-vision:11b-instruct-q4_0  # ~7GB RAM
ollama pull moondream:1.8b-v2-q4_0             # ~1.5GB RAM, basic vision
```
