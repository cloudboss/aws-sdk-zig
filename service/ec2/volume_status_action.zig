/// Describes a volume status operation code.
pub const VolumeStatusAction = struct {
    /// The code identifying the operation, for example, `enable-volume-io`.
    code: ?[]const u8 = null,

    /// A description of the operation.
    description: ?[]const u8 = null,

    /// The ID of the event associated with this operation.
    event_id: ?[]const u8 = null,

    /// The event type associated with this operation.
    event_type: ?[]const u8 = null,
};
