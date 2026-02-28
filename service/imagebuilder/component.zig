const aws = @import("aws");

const ComponentParameterDetail = @import("component_parameter_detail.zig").ComponentParameterDetail;
const Platform = @import("platform.zig").Platform;
const ProductCodeListItem = @import("product_code_list_item.zig").ProductCodeListItem;
const ComponentState = @import("component_state.zig").ComponentState;
const ComponentType = @import("component_type.zig").ComponentType;

/// A detailed view of a component.
pub const Component = struct {
    /// The Amazon Resource Name (ARN) of the component.
    arn: ?[]const u8,

    /// Describes what change has been made in this version of the component,
    /// or what makes this version different from other versions of the component.
    change_description: ?[]const u8,

    /// Component data contains the YAML document content for the component.
    data: ?[]const u8,

    /// The date that Image Builder created the component.
    date_created: ?[]const u8,

    /// The description of the component.
    description: ?[]const u8,

    /// The encryption status of the component.
    encrypted: ?bool,

    /// The KMS key identifier used to encrypt the component. This can be either the
    /// Key ARN or the Alias ARN. For more information, see [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// The name of the component.
    name: ?[]const u8,

    /// Indicates whether component source is hidden from view in the console, and
    /// from
    /// component detail results for API, CLI, or SDK operations.
    obfuscate: bool = false,

    /// The owner of the component.
    owner: ?[]const u8,

    /// Contains parameter details for each of the parameters that the component
    /// document
    /// defined for the component.
    parameters: ?[]const ComponentParameterDetail,

    /// The operating system platform of the component.
    platform: ?Platform,

    /// Contains product codes that are used for billing purposes for Amazon Web
    /// Services Marketplace components.
    product_codes: ?[]const ProductCodeListItem,

    /// Contains the name of the publisher if this is a third-party component.
    /// Otherwise,
    /// this property is empty.
    publisher: ?[]const u8,

    /// Describes the current status of the component.
    state: ?ComponentState,

    /// The operating system (OS) version supported by the component. If the OS
    /// information is
    /// available, Image Builder performs a prefix match against the base image OS
    /// version during image
    /// recipe creation.
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
        .data = "data",
        .date_created = "dateCreated",
        .description = "description",
        .encrypted = "encrypted",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .obfuscate = "obfuscate",
        .owner = "owner",
        .parameters = "parameters",
        .platform = "platform",
        .product_codes = "productCodes",
        .publisher = "publisher",
        .state = "state",
        .supported_os_versions = "supportedOsVersions",
        .tags = "tags",
        .@"type" = "type",
        .version = "version",
    };
};
