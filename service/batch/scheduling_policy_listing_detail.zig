/// An object that contains the details of a scheduling policy that's returned
/// in a
/// `ListSchedulingPolicy` action.
pub const SchedulingPolicyListingDetail = struct {
    /// Amazon Resource Name (ARN) of the scheduling policy.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
