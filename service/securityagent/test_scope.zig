const TestScopeType = @import("test_scope_type.zig").TestScopeType;

/// The category of application a pentest targets.
pub const TestScope = struct {
    /// The category of application under test.
    type: TestScopeType,

    pub const json_field_names = .{
        .type = "type",
    };
};
