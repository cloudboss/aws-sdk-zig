const aws = @import("aws");

const Platform = @import("platform.zig").Platform;
const ComponentState = @import("component_state.zig").ComponentState;
const ComponentType = @import("component_type.zig").ComponentType;

/// A high-level summary of a component.
pub const ComponentSummary = struct {
    /// The Amazon Resource Name (ARN) of the component.
    arn: ?[]const u8,

    /// The change description for the current version of the component.
    change_description: ?[]const u8,

    /// The original creation date of the component.
    date_created: ?[]const u8,

    /// The description of the component.
    description: ?[]const u8,

    /// The name of the component.
    name: ?[]const u8,

    /// Indicates whether component source is hidden from view in the console, and
    /// from
    /// component detail results for API, CLI, or SDK operations.
    obfuscate: bool = false,

    /// The owner of the component.
    owner: ?[]const u8,

    /// The operating system platform of the component.
    platform: ?Platform,

    /// Contains the name of the publisher if this is a third-party component.
    /// Otherwise,
    /// this property is empty.
    publisher: ?[]const u8,

    /// Describes the current status of the component.
    state: ?ComponentState,

    /// The operating system (OS) version that the component supports. If the OS
    /// information
    /// is available, Image Builder performs a prefix match against the base image
    /// OS version during
    /// image recipe creation.
    supported_os_versions: ?[]const []const u8,

    /// The tags that apply to the component.
    tags: ?[]const aws.map.StringMapEntry,

    /// The component type specifies whether Image Builder uses the component to
    /// build the image or
    /// only to test it.
    @"type": ?ComponentType,

    /// The version of the component.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .change_description = "changeDescription",
        .date_created = "dateCreated",
        .description = "description",
        .name = "name",
        .obfuscate = "obfuscate",
        .owner = "owner",
        .platform = "platform",
        .publisher = "publisher",
        .state = "state",
        .supported_os_versions = "supportedOsVersions",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
    };
};
