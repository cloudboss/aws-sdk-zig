const PolicyStatement = @import("policy_statement.zig").PolicyStatement;

/// SignIn resource-based policy document
pub const SigninResourceBasedPolicy = struct {
    /// Policy statements
    statement: ?[]const PolicyStatement = null,

    /// Policy version
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .statement = "statement",
        .version = "version",
    };
};
