const UploadCategory = @import("upload_category.zig").UploadCategory;
const UploadStatus = @import("upload_status.zig").UploadStatus;
const UploadType = @import("upload_type.zig").UploadType;

/// An app or a set of one or more tests to upload or that have been
/// uploaded.
pub const Upload = struct {
    /// The upload's ARN.
    arn: ?[]const u8 = null,

    /// The upload's category. Allowed values include:
    ///
    /// * CURATED: An upload managed by AWS Device Farm.
    ///
    /// * PRIVATE: An upload managed by the AWS Device Farm customer.
    category: ?UploadCategory = null,

    /// The upload's content type (for example, `application/octet-stream`).
    content_type: ?[]const u8 = null,

    /// When the upload was created.
    created: ?i64 = null,

    /// A message about the upload's result.
    message: ?[]const u8 = null,

    /// The upload's metadata. For example, for Android, this contains information
    /// that is
    /// parsed from the manifest and is displayed in the AWS Device Farm console
    /// after the
    /// associated app is uploaded.
    metadata: ?[]const u8 = null,

    /// The upload's file name.
    name: ?[]const u8 = null,

    /// The upload's status.
    ///
    /// Must be one of the following values:
    ///
    /// * FAILED
    ///
    /// * INITIALIZED
    ///
    /// * PROCESSING
    ///
    /// * SUCCEEDED
    status: ?UploadStatus = null,

    /// The upload's type.
    ///
    /// Must be one of the following values:
    ///
    /// * ANDROID_APP
    ///
    /// * IOS_APP
    ///
    /// * WEB_APP
    ///
    /// * EXTERNAL_DATA
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_RUBY_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_PYTHON_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_NODE_TEST_PACKAGE
    ///
    /// * APPIUM_WEB_RUBY_TEST_PACKAGE
    ///
    /// * INSTRUMENTATION_TEST_PACKAGE
    ///
    /// * XCTEST_TEST_PACKAGE
    ///
    /// * XCTEST_UI_TEST_PACKAGE
    ///
    /// * APPIUM_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_NODE_TEST_SPEC
    ///
    /// * APPIUM_RUBY_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_JUNIT_TEST_SPEC
    ///
    /// * APPIUM_WEB_JAVA_TESTNG_TEST_SPEC
    ///
    /// * APPIUM_WEB_PYTHON_TEST_SPEC
    ///
    /// * APPIUM_WEB_NODE_TEST_SPEC
    ///
    /// * APPIUM_WEB_RUBY_TEST_SPEC
    ///
    /// * INSTRUMENTATION_TEST_SPEC
    ///
    /// * XCTEST_UI_TEST_SPEC
    @"type": ?UploadType = null,

    /// The presigned Amazon S3 URL that was used to store a file using a PUT
    /// request.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .category = "category",
        .content_type = "contentType",
        .created = "created",
        .message = "message",
        .metadata = "metadata",
        .name = "name",
        .status = "status",
        .@"type" = "type",
        .url = "url",
    };
};
