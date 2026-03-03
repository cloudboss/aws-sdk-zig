const std = @import("std");

/// The training input mode that the algorithm supports. For more information
/// about input modes, see
/// [Algorithms](https://docs.aws.amazon.com/sagemaker/latest/dg/algos.html).
///
/// **Pipe mode**
///
/// If an algorithm supports `Pipe` mode, Amazon SageMaker streams data directly
/// from Amazon S3 to the container.
///
/// **File mode**
///
/// If an algorithm supports `File` mode, SageMaker downloads the training data
/// from S3 to the provisioned ML storage volume, and mounts the directory to
/// the Docker volume for the training container.
///
/// You must provision the ML storage volume with sufficient capacity to
/// accommodate the data downloaded from S3. In addition to the training data,
/// the ML storage volume also stores the output model. The algorithm container
/// uses the ML storage volume to also store intermediate information, if any.
///
/// For distributed algorithms, training data is distributed uniformly. Your
/// training duration is predictable if the input data objects sizes are
/// approximately the same. SageMaker does not split the files any further for
/// model training. If the object sizes are skewed, training won't be optimal as
/// the data distribution is also skewed when one host in a training cluster is
/// overloaded, thus becoming a bottleneck in training.
///
/// **FastFile mode**
///
/// If an algorithm supports `FastFile` mode, SageMaker streams data directly
/// from S3 to the container with no code changes, and provides file system
/// access to the data. Users can author their training script to interact with
/// these files as if they were stored on disk.
///
/// `FastFile` mode works best when the data is read sequentially. Augmented
/// manifest files aren't supported. The startup time is lower when there are
/// fewer files in the S3 bucket provided.
pub const TrainingInputMode = enum {
    pipe,
    file,
    fastfile,

    pub const json_field_names = .{
        .pipe = "Pipe",
        .file = "File",
        .fastfile = "FastFile",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pipe => "Pipe",
            .file => "File",
            .fastfile => "FastFile",
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
