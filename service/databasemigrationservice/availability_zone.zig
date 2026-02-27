/// The name of an Availability Zone for use during database migration.
/// `AvailabilityZone` is an optional parameter to the [
/// `CreateReplicationInstance`
/// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_CreateReplicationInstance.html) operation, and it’s value relates to
/// the Amazon Web Services Region of an endpoint. For example, the availability
/// zone of an endpoint in the
/// us-east-1 region might be us-east-1a, us-east-1b, us-east-1c, or us-east-1d.
pub const AvailabilityZone = struct {
    /// The name of the Availability Zone.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
