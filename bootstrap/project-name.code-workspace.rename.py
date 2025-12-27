from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from autocodegen import Context


def rename(ctx: Context) -> str:
    return f"{ctx.project_config.autocodegen.project_name}.code-workspace"
