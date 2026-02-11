const TenantIsolationMode = @import("tenant_isolation_mode.zig").TenantIsolationMode;

/// Specifies the tenant isolation mode configuration for a Lambda function.
/// This allows you to configure specific tenant isolation strategies for your
/// function invocations. Tenant isolation configuration cannot be modified
/// after function creation.
pub const TenancyConfig = struct {
    /// Tenant isolation mode allows for invocation to be sent to a corresponding
    /// execution environment dedicated to a specific tenant ID.
    tenant_isolation_mode: TenantIsolationMode,

    pub const json_field_names = .{
        .tenant_isolation_mode = "TenantIsolationMode",
    };
};
