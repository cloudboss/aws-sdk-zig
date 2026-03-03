/// A Lake Formation condition, which applies to permissions and opt-ins that
/// contain an expression.
pub const Condition = struct {
    /// An expression written based on the Cedar Policy Language used to match the
    /// principal attributes.
    expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .expression = "Expression",
    };
};
