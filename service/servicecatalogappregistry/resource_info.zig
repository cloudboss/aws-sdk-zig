const AssociationOption = @import("association_option.zig").AssociationOption;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ResourceType = @import("resource_type.zig").ResourceType;

/// The information about the resource.
pub const ResourceInfo = struct {
    /// The Amazon resource name (ARN) that specifies the resource across services.
    arn: ?[]const u8,

    /// The name of the resource.
    name: ?[]const u8,

    /// Determines whether an application tag is applied or skipped.
    options: ?[]const AssociationOption,

    /// The details related
    /// to
    /// the resource.
    resource_details: ?ResourceDetails,

    /// Provides information
    /// about the Service Catalog App Registry resource type.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .options = "options",
        .resource_details = "resourceDetails",
        .resource_type = "resourceType",
    };
};
