@echo off
for %%f in (*.asm) do (
    python assembler.py %%f
)