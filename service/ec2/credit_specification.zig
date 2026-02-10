/// Describes the credit option for CPU usage of a T instance.
pub const CreditSpecification = struct {
    /// The credit option for CPU usage of a T instance.
    ///
    /// Valid values: `standard` | `unlimited`
    cpu_credits: ?[]const u8,
};
