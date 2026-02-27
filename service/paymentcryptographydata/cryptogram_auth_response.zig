const CryptogramVerificationArpcMethod1 = @import("cryptogram_verification_arpc_method_1.zig").CryptogramVerificationArpcMethod1;
const CryptogramVerificationArpcMethod2 = @import("cryptogram_verification_arpc_method_2.zig").CryptogramVerificationArpcMethod2;

/// Parameters that are required for Authorization Response Cryptogram (ARPC)
/// generation after Authorization Request Cryptogram (ARQC) verification is
/// successful.
pub const CryptogramAuthResponse = union(enum) {
    /// Parameters that are required for ARPC response generation using method1
    /// after ARQC verification is successful.
    arpc_method_1: ?CryptogramVerificationArpcMethod1,
    /// Parameters that are required for ARPC response generation using method2
    /// after ARQC verification is successful.
    arpc_method_2: ?CryptogramVerificationArpcMethod2,

    pub const json_field_names = .{
        .arpc_method_1 = "ArpcMethod1",
        .arpc_method_2 = "ArpcMethod2",
    };
};
