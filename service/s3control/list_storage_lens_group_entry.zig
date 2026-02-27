/// Each entry contains a Storage Lens group that exists in the specified home
/// Region.
pub const ListStorageLensGroupEntry = struct {
    /// Contains the Amazon Web Services Region where the Storage Lens group was
    /// created.
    home_region: []const u8,

    /// Contains the name of the Storage Lens group that exists in the specified
    /// home Region.
    name: []const u8,

    /// Contains the Amazon Resource Name (ARN) of the Storage Lens group. This
    /// property is read-only.
    storage_lens_group_arn: []const u8,
};
