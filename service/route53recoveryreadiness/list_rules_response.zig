const ListRulesOutput = @import("list_rules_output.zig").ListRulesOutput;

pub const ListRulesResponse = struct {
    /// The token that identifies which batch of results you want to see.
    next_token: ?[]const u8,

    /// A list of readiness rules for a specific resource type.
    rules: ?[]const ListRulesOutput,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rules = "Rules",
    };
};
