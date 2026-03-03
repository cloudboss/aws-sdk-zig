/// Describes a disk image volume.
pub const DiskImageVolumeDescription = struct {
    /// The volume identifier.
    id: ?[]const u8 = null,

    /// The size of the volume, in GiB.
    size: ?i64 = null,
};
