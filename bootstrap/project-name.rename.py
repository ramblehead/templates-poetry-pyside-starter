from typing import TYPE_CHECKING

from autocodegen.utils import snake_case

if TYPE_CHECKING:
    from autocodegen import Context


def rename(ctx: Context) -> str:
    return snake_case(ctx.project_config.autocodegen.project_name)
