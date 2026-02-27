const CapabilityDirection = @import("capability_direction.zig").CapabilityDirection;
const S3Location = @import("s3_location.zig").S3Location;
const EdiType = @import("edi_type.zig").EdiType;

/// Specifies the details for the EDI (electronic data interchange)
/// transformation.
pub const EdiConfiguration = struct {
    /// Specifies whether this is capability is for inbound or outbound
    /// transformations.
    capability_direction: ?CapabilityDirection,

    /// Contains the Amazon S3 bucket and prefix for the location of the input file,
    /// which is contained in an `S3Location` object.
    input_location: S3Location,

    /// Contains the Amazon S3 bucket and prefix for the location of the output
    /// file, which is contained in an `S3Location` object.
    output_location: S3Location,

    /// Returns the system-assigned unique identifier for the transformer.
    transformer_id: []const u8,

    /// Returns the type of the capability. Currently, only `edi` is supported.
    @"type": EdiType,

    pub const json_field_names = .{
        .capability_direction = "capabilityDirection",
        .input_location = "inputLocation",
        .output_location = "outputLocation",
        .transformer_id = "transformerId",
        .@"type" = "type",
    };
};
