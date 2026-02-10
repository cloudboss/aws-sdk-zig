/// Describes a disk image volume.
pub const DiskImageVolumeDescription = struct {
    /// The volume identifier.
    id: ?[]const u8,

    /// The size of the volume, in GiB.
    size: ?i64,
};
