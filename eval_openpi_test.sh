#!/bin/bash
set -euo pipefail

export MUJOCO_GL=egl
export PYOPENGL_PLATFORM=egl
export MUJOCO_EGL_DEVICE_ID=0

POLICY="openpi"
OPENPI_CONFIG="pi0_vlabench_primitive"
MODEL_CKPT="/seu_share/home/wangshuai01/213221090/hf_cache/pi0-primitive-10task"

python scripts/evaluate_policy.py \
    --tasks select_fruit \
    --eval-track track_1_in_distribution \
    --n-episode 1 \
    --policy "$POLICY" \
    --openpi-config "$OPENPI_CONFIG" \
    --model_ckpt "$MODEL_CKPT" \
    --metrics progress_score
