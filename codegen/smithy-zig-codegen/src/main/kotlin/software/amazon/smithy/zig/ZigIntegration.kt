package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SmithyIntegration

interface ZigIntegration : SmithyIntegration<ZigSettings, ZigWriter, ZigContext>
