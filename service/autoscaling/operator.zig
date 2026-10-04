/// Describes the entity that manages an Auto Scaling group.
pub const Operator = struct {
    /// The service principal that is authorized to manage the Auto Scaling group.
    /// When an operator is
    /// specified, only the designated operator service principal can make mutating
    /// changes to
    /// the Auto Scaling group.
    principal: []const u8,
};
