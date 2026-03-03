/// An Amazon Web Services Region in which Amazon Web Services Control Tower
/// expects to find the control deployed.
///
/// The expected Regions are based on the Regions that are governed by the
/// landing zone. In certain cases, a control is not actually enabled in the
/// Region as expected, such as during drift, or [mixed
/// governance](https://docs.aws.amazon.com/controltower/latest/userguide/region-how.html#mixed-governance).
pub const Region = struct {
    /// The Amazon Web Services Region name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
    };
};
