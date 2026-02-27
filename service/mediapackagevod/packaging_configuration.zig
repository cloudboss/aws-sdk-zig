const aws = @import("aws");

const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;

/// A MediaPackage VOD PackagingConfiguration resource.
pub const PackagingConfiguration = struct {
    /// The ARN of the PackagingConfiguration.
    arn: ?[]const u8,

    cmaf_package: ?CmafPackage,

    /// The time the PackagingConfiguration was created.
    created_at: ?[]const u8,

    dash_package: ?DashPackage,

    hls_package: ?HlsPackage,

    /// The ID of the PackagingConfiguration.
    id: ?[]const u8,

    mss_package: ?MssPackage,

    /// The ID of a PackagingGroup.
    packaging_group_id: ?[]const u8,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .cmaf_package = "CmafPackage",
        .created_at = "CreatedAt",
        .dash_package = "DashPackage",
        .hls_package = "HlsPackage",
        .id = "Id",
        .mss_package = "MssPackage",
        .packaging_group_id = "PackagingGroupId",
        .tags = "Tags",
    };
};
