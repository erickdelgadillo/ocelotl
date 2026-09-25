# Ocelotl — Roadmap and Next Task

## NOW — documentation synchronization

Before larger feature work:

1. Make README release-version references consistent.
2. Update `docs/architecture.md` so the current role inventory includes `libresprite`.
3. Confirm CI status after documentation cleanup.
4. Keep role READMEs synchronized with role behavior.

These are documentation-maintenance tasks, not architecture changes.

## NEXT — engineering maturity

Choose one coherent milestone rather than adding unrelated roles.

Strong candidates already aligned with the repository roadmap:

- Git configuration role;
- automated testing across multiple supported Ubuntu versions;
- named bioinformatics Conda environments;
- additional quality/lint checks where justified.

Selection should be based on current need, not feature count.

## LATER — broader platform capabilities

Potential future directions:

- Apptainer / Singularity;
- CUDA / NVIDIA tooling;
- HPC / SLURM profiles;
- cloud profiles;
- optional workstation profiles;
- additional scientific CLI tools.

These should not dilute the current goal of a reliable local scientific workstation.

## Release discipline

When preparing a new release:

- confirm implementation state;
- confirm CI/idempotence;
- update changelog;
- synchronize README version references;
- create the tag/release only when explicitly approved.

Do not infer release state from a stale badge.

## Definition of a good next feature

A new feature should:

1. solve a real workstation-management need;
2. fit cleanly into the current role architecture;
3. preserve idempotence;
4. expose configuration through defaults when appropriate;
5. include verification;
6. update documentation;
7. pass CI without introducing hidden dependencies.
