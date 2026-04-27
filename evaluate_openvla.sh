#!/bin/bash
set -euo pipefail

export MUJOCO_GL=egl
export PYOPENGL_PLATFORM=egl
export MUJOCO_EGL_DEVICE_ID=0

eval_tracks=(
    "track_1_in_distribution"
    "track_2_cross_category"
    "track_3_common_sense"
    "track_4_semantic_instruction"
    "track_6_unseen_texture"
)

EPISODE=3
POLICY="openvla"
MODEL_CKPT="/seu_share/home/wangshuai01/213221090/hf_cache/openvla-lora"
METRICS="success_rate intention_score progress_score"

for eval_track in "${eval_tracks[@]}"; do
    echo "Evaluating on eval track: $eval_track"
    python scripts/evaluate_policy.py \
        --eval-track "$eval_track" \
        --n-episode "$EPISODE" \
        --policy "$POLICY" \
        --model_ckpt "$MODEL_CKPT" \
        --metrics $METRICS
done