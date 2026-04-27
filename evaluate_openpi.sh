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

models=(
    "pi0:pi0_vlabench_primitive:/seu_share/home/wangshuai01/213221090/hf_cache/pi0-primitive-10task"
)

EPISODE=3
POLICY="openpi"
METRICS="success_rate intention_score progress_score"

for model_spec in "${models[@]}"; do
    IFS=":" read -r model_name openpi_config model_ckpt <<< "$model_spec"

    for eval_track in "${eval_tracks[@]}"; do
        echo "Evaluating $model_name on eval track: $eval_track"
        python scripts/evaluate_policy.py \
            --eval-track "$eval_track" \
            --n-episode "$EPISODE" \
            --policy "$POLICY" \
            --openpi-config "$openpi_config" \
            --model_ckpt "$model_ckpt" \
            --save-dir "logs/$model_name" \
            --visulization \
            --metrics $METRICS
    done
done
