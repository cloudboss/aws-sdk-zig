const std = @import("std");

pub const CustomWorkspaceImageImportState = enum {
    pending,
    in_progress,
    processing_source_image,
    image_testing_start,
    updating_operating_system,
    image_compatibility_checking,
    image_testing_generalization,
    creating_test_instance,
    installing_components,
    generalizing,
    validating,
    publishing,
    completed,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .processing_source_image = "PROCESSING_SOURCE_IMAGE",
        .image_testing_start = "IMAGE_TESTING_START",
        .updating_operating_system = "UPDATING_OPERATING_SYSTEM",
        .image_compatibility_checking = "IMAGE_COMPATIBILITY_CHECKING",
        .image_testing_generalization = "IMAGE_TESTING_GENERALIZATION",
        .creating_test_instance = "CREATING_TEST_INSTANCE",
        .installing_components = "INSTALLING_COMPONENTS",
        .generalizing = "GENERALIZING",
        .validating = "VALIDATING",
        .publishing = "PUBLISHING",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .processing_source_image => "PROCESSING_SOURCE_IMAGE",
            .image_testing_start => "IMAGE_TESTING_START",
            .updating_operating_system => "UPDATING_OPERATING_SYSTEM",
            .image_compatibility_checking => "IMAGE_COMPATIBILITY_CHECKING",
            .image_testing_generalization => "IMAGE_TESTING_GENERALIZATION",
            .creating_test_instance => "CREATING_TEST_INSTANCE",
            .installing_components => "INSTALLING_COMPONENTS",
            .generalizing => "GENERALIZING",
            .validating => "VALIDATING",
            .publishing => "PUBLISHING",
            .completed => "COMPLETED",
            .@"error" => "ERROR",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
