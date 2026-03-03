const aws = @import("aws");

const BlueprintStage = @import("blueprint_stage.zig").BlueprintStage;
const BlueprintOptimizationSample = @import("blueprint_optimization_sample.zig").BlueprintOptimizationSample;
const Type = @import("type.zig").Type;

/// Contains the information of a Blueprint.
pub const Blueprint = struct {
    blueprint_arn: []const u8,

    blueprint_name: []const u8,

    blueprint_stage: ?BlueprintStage = null,

    blueprint_version: ?[]const u8 = null,

    creation_time: i64,

    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    kms_key_id: ?[]const u8 = null,

    last_modified_time: i64,

    optimization_samples: ?[]const BlueprintOptimizationSample = null,

    optimization_time: ?i64 = null,

    schema: []const u8,

    @"type": Type,

    pub const json_field_names = .{
        .blueprint_arn = "blueprintArn",
        .blueprint_name = "blueprintName",
        .blueprint_stage = "blueprintStage",
        .blueprint_version = "blueprintVersion",
        .creation_time = "creationTime",
        .kms_encryption_context = "kmsEncryptionContext",
        .kms_key_id = "kmsKeyId",
        .last_modified_time = "lastModifiedTime",
        .optimization_samples = "optimizationSamples",
        .optimization_time = "optimizationTime",
        .schema = "schema",
        .@"type" = "type",
    };
};
