const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const BuildStatus = @import("build_status.zig").BuildStatus;

/// Properties describing a custom game build.
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const Build = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers build resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::build/build-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`. In a
    /// GameLift build ARN, the resource ID matches the
    /// *BuildId* value.
    build_arn: ?[]const u8,

    /// A unique identifier for the build.
    build_id: ?[]const u8,

    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// A descriptive label that is associated with a build. Build names do not need
    /// to be unique. It can be set using
    /// [CreateBuild](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateBuild.html) or
    /// [UpdateBuild](https://docs.aws.amazon.com/gamelift/latest/apireference/UpdateBuild).
    name: ?[]const u8,

    /// Operating system that the game server binaries are built to run on. This
    /// value
    /// determines the type of fleet resources that you can use for this build.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in
    /// the [Amazon Linux 2 FAQs](http://aws.amazon.com/amazon-linux-2/faqs/).
    /// For game servers
    /// that are hosted on AL2 and use server SDK version 4.x for Amazon GameLift
    /// Servers, first update the
    /// game server build to server SDK 5.x, and then deploy to AL2023 instances.
    /// See
    /// [
    /// Migrate to server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?OperatingSystem,

    /// The Amazon GameLift Servers Server SDK version used to develop your game
    /// server.
    server_sdk_version: ?[]const u8,

    /// File size of the uploaded game build, expressed in bytes. When the build
    /// status is
    /// `INITIALIZED` or when using a custom Amazon S3 storage location, this value
    /// is
    /// 0.
    size_on_disk: ?i64,

    /// Current status of the build.
    ///
    /// Possible build statuses include the following:
    ///
    /// * **INITIALIZED** -- A new build has been defined,
    /// but no files have been uploaded. You cannot create fleets for builds that
    /// are in
    /// this status. When a build is successfully created, the build status is set
    /// to
    /// this value.
    ///
    /// * **READY** -- The game build has been successfully
    /// uploaded. You can now create new fleets for this build.
    ///
    /// * **FAILED** -- The game build upload failed. You
    /// cannot create new fleets for this build.
    status: ?BuildStatus,

    /// Version information that is associated with a build or script. Version
    /// strings do not need to be unique.
    version: ?[]const u8,

    pub const json_field_names = .{
        .build_arn = "BuildArn",
        .build_id = "BuildId",
        .creation_time = "CreationTime",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .server_sdk_version = "ServerSdkVersion",
        .size_on_disk = "SizeOnDisk",
        .status = "Status",
        .version = "Version",
    };
};
