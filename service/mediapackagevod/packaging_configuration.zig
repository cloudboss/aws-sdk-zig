const aws = @import("aws");

const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;

/// A MediaPackage VOD PackagingConfiguration resource.
pub const PackagingConfiguration = struct {
    /// The ARN of the PackagingConfiguration.
    arn: ?[]const u8 = null,

    cmaf_package: ?CmafPackage = null,

    /// The time the PackagingConfiguration was created.
    created_at: ?[]const u8 = null,

    dash_package: ?DashPackage = null,

    hls_package: ?HlsPackage = null,

    /// The ID of the PackagingConfiguration.
    id: ?[]const u8 = null,

    mss_package: ?MssPackage = null,

    /// The ID of a PackagingGroup.
    packaging_group_id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

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
