pub const MultiRegionAccessPointStatus = enum {
    ready,
    inconsistent_across_regions,
    creating,
    partially_created,
    partially_deleted,
    deleting,
};
