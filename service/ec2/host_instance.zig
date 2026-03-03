/// Describes an instance running on a Dedicated Host.
pub const HostInstance = struct {
    /// The ID of instance that is running on the Dedicated Host.
    instance_id: ?[]const u8 = null,

    /// The instance type (for example, `m3.medium`) of the running
    /// instance.
    instance_type: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the instance.
    owner_id: ?[]const u8 = null,
};
