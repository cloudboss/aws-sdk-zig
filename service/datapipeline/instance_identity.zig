/// Identity information for the EC2 instance that is hosting the task runner.
/// You can get this value by calling a metadata URI from the EC2 instance.
/// For more information, see [Instance
/// Metadata](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AESDG-chapter-instancedata.html) in the *Amazon Elastic Compute Cloud User Guide.*
/// Passing in this value proves that your task runner is running on an EC2
/// instance, and ensures the proper AWS Data Pipeline service charges are
/// applied to your pipeline.
pub const InstanceIdentity = struct {
    /// A description of an EC2 instance that is generated when the instance is
    /// launched and exposed to the instance via the instance metadata service in
    /// the form of a JSON representation of an object.
    document: ?[]const u8,

    /// A signature which can be used to verify the accuracy and authenticity of the
    /// information provided in the instance identity document.
    signature: ?[]const u8,

    pub const json_field_names = .{
        .document = "document",
        .signature = "signature",
    };
};
