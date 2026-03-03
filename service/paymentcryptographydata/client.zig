const aws = @import("aws");
const std = @import("std");

const decrypt_data = @import("decrypt_data.zig");
const encrypt_data = @import("encrypt_data.zig");
const generate_as_2805_kek_validation = @import("generate_as_2805_kek_validation.zig");
const generate_card_validation_data = @import("generate_card_validation_data.zig");
const generate_mac = @import("generate_mac.zig");
const generate_mac_emv_pin_change = @import("generate_mac_emv_pin_change.zig");
const generate_pin_data = @import("generate_pin_data.zig");
const re_encrypt_data = @import("re_encrypt_data.zig");
const translate_key_material = @import("translate_key_material.zig");
const translate_pin_data = @import("translate_pin_data.zig");
const verify_auth_request_cryptogram = @import("verify_auth_request_cryptogram.zig");
const verify_card_validation_data = @import("verify_card_validation_data.zig");
const verify_mac = @import("verify_mac.zig");
const verify_pin_data = @import("verify_pin_data.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Payment Cryptography Data";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Decrypts ciphertext data to plaintext using a symmetric (TDES, AES),
    /// asymmetric (RSA), or derived (DUKPT or EMV) encryption key scheme. For more
    /// information, see [Decrypt
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/decrypt-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// You can use an decryption key generated within Amazon Web Services Payment
    /// Cryptography, or you can import your own decryption key by calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html). For this operation, the key must have `KeyModesOfUse` set to `Decrypt`. In asymmetric decryption, Amazon Web Services Payment Cryptography decrypts the ciphertext using the private component of the asymmetric encryption key pair. For data encryption outside of Amazon Web Services Payment Cryptography, you can export the public component of the asymmetric key pair by calling [GetPublicCertificate](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetPublicKeyCertificate.html).
    ///
    /// This operation also supports dynamic keys, allowing you to pass a dynamic
    /// decryption key as a TR-31 WrappedKeyBlock. This can be used when key
    /// material is frequently rotated, such as during every card transaction, and
    /// there is need to avoid importing short-lived keys into Amazon Web Services
    /// Payment Cryptography. To decrypt using dynamic keys, the `keyARN` is the Key
    /// Encryption Key (KEK) of the TR-31 wrapped decryption key material. The
    /// incoming wrapped key shall have a key purpose of D0 with a mode of use of B
    /// or D. For more information, see [Using Dynamic
    /// Keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/use-cases-acquirers-dynamickeys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// For symmetric and DUKPT decryption, Amazon Web Services Payment Cryptography
    /// supports `TDES` and `AES` algorithms. For EMV decryption, Amazon Web
    /// Services Payment Cryptography supports `TDES` algorithms. For asymmetric
    /// decryption, Amazon Web Services Payment Cryptography supports `RSA`.
    ///
    /// When you use TDES or TDES DUKPT, the ciphertext data length must be a
    /// multiple of 8 bytes. For AES or AES DUKPT, the ciphertext data length must
    /// be a multiple of 16 bytes. For RSA, it sould be equal to the key size unless
    /// padding is enabled.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * EncryptData
    /// *
    ///   [GetPublicCertificate](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetPublicKeyCertificate.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    pub fn decryptData(self: *Self, allocator: std.mem.Allocator, input: decrypt_data.DecryptDataInput, options: decrypt_data.Options) !decrypt_data.DecryptDataOutput {
        return decrypt_data.execute(self, allocator, input, options);
    }

    /// Encrypts plaintext data to ciphertext using a symmetric (TDES, AES),
    /// asymmetric (RSA), or derived (DUKPT or EMV) encryption key scheme. For more
    /// information, see [Encrypt
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/encrypt-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// You can generate an encryption key within Amazon Web Services Payment
    /// Cryptography by calling
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html). You can import your own encryption key by calling [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html).
    ///
    /// For this operation, the key must have `KeyModesOfUse` set to `Encrypt`. In
    /// asymmetric encryption, plaintext is encrypted using public component. You
    /// can import the public component of an asymmetric key pair created outside
    /// Amazon Web Services Payment Cryptography by calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html).
    ///
    /// This operation also supports dynamic keys, allowing you to pass a dynamic
    /// encryption key as a TR-31 WrappedKeyBlock. This can be used when key
    /// material is frequently rotated, such as during every card transaction, and
    /// there is need to avoid importing short-lived keys into Amazon Web Services
    /// Payment Cryptography. To encrypt using dynamic keys, the `keyARN` is the Key
    /// Encryption Key (KEK) of the TR-31 wrapped encryption key material. The
    /// incoming wrapped key shall have a key purpose of D0 with a mode of use of B
    /// or D. For more information, see [Using Dynamic
    /// Keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/use-cases-acquirers-dynamickeys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// For symmetric and DUKPT encryption, Amazon Web Services Payment Cryptography
    /// supports `TDES` and `AES` algorithms. For EMV encryption, Amazon Web
    /// Services Payment Cryptography supports `TDES` algorithms.For asymmetric
    /// encryption, Amazon Web Services Payment Cryptography supports `RSA`.
    ///
    /// When you use TDES or TDES DUKPT, the plaintext data length must be a
    /// multiple of 8 bytes. For AES or AES DUKPT, the plaintext data length must be
    /// a multiple of 16 bytes. For RSA, it sould be equal to the key size unless
    /// padding is enabled.
    ///
    /// To encrypt using DUKPT, you must already have a BDK (Base Derivation Key)
    /// key in your account with `KeyModesOfUse` set to `DeriveKey`, or you can
    /// generate a new DUKPT key by calling
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html). To encrypt using EMV, you must already have an IMK (Issuer Master Key) key in your account with `KeyModesOfUse` set to `DeriveKey`.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * DecryptData
    /// *
    ///   [GetPublicCertificate](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetPublicKeyCertificate.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    /// * ReEncryptData
    pub fn encryptData(self: *Self, allocator: std.mem.Allocator, input: encrypt_data.EncryptDataInput, options: encrypt_data.Options) !encrypt_data.EncryptDataOutput {
        return encrypt_data.execute(self, allocator, input, options);
    }

    /// Establishes node-to-node initialization between payment processing nodes
    /// such as an acquirer, issuer or payment network using Australian Standard
    /// 2805 (AS2805).
    ///
    /// During node-to-node initialization, both communicating nodes must validate
    /// that they possess the correct Key Encrypting Keys (KEKs) before proceeding
    /// with session key exchange. In AS2805, the sending KEK (KEKs) of one node
    /// corresponds to the receiving KEK (KEKr) of its partner node. Each node uses
    /// its KEK to encrypt and decrypt session keys exchanged between the nodes. A
    /// KEK can be created or imported into Amazon Web Services Payment Cryptography
    /// using either the
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html) or [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html) operations.
    ///
    /// The node initiating communication can use `GenerateAS2805KekValidation` to
    /// generate a combined KEK validation request and KEK validation response to
    /// send to the partnering node for validation. When invoked, the API internally
    /// generates a random sending key encrypted under KEKs and provides a receiving
    /// key encrypted under KEKr as response. The initiating node sends the response
    /// returned by this API to its partner for validation.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    pub fn generateAs2805KekValidation(self: *Self, allocator: std.mem.Allocator, input: generate_as_2805_kek_validation.GenerateAs2805KekValidationInput, options: generate_as_2805_kek_validation.Options) !generate_as_2805_kek_validation.GenerateAs2805KekValidationOutput {
        return generate_as_2805_kek_validation.execute(self, allocator, input, options);
    }

    /// Generates card-related validation data using algorithms such as Card
    /// Verification Values (CVV/CVV2), Dynamic Card Verification Values
    /// (dCVV/dCVV2), or Card Security Codes (CSC). For more information, see
    /// [Generate card
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/generate-card-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// This operation generates a CVV or CSC value that is printed on a payment
    /// credit or debit card during card production. The CVV or CSC, PAN (Primary
    /// Account Number) and expiration date of the card are required to check its
    /// validity during transaction processing. To begin this operation, a CVK (Card
    /// Verification Key) encryption key is required. You can use
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html) or [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html) to establish a CVK within Amazon Web Services Payment Cryptography. The `KeyModesOfUse` should be set to `Generate` and `Verify` for a CVK encryption key.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    /// * VerifyCardValidationData
    pub fn generateCardValidationData(self: *Self, allocator: std.mem.Allocator, input: generate_card_validation_data.GenerateCardValidationDataInput, options: generate_card_validation_data.Options) !generate_card_validation_data.GenerateCardValidationDataOutput {
        return generate_card_validation_data.execute(self, allocator, input, options);
    }

    /// Generates a Message Authentication Code (MAC) cryptogram within Amazon Web
    /// Services Payment Cryptography.
    ///
    /// You can use this operation to authenticate card-related data by using known
    /// data values to generate MAC for data validation between the sending and
    /// receiving parties. This operation uses message data, a secret encryption key
    /// and MAC algorithm to generate a unique MAC value for transmission. The
    /// receiving party of the MAC must use the same message data, secret encryption
    /// key and MAC algorithm to reproduce another MAC value for comparision.
    ///
    /// You can use this operation to generate a DUPKT, CMAC, HMAC or EMV MAC by
    /// setting generation attributes and algorithm to the associated values. The
    /// MAC generation encryption key must have valid values for `KeyUsage` such as
    /// `TR31_M7_HMAC_KEY` for HMAC generation, and the key must have
    /// `KeyModesOfUse` set to `Generate`.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * VerifyMac
    pub fn generateMac(self: *Self, allocator: std.mem.Allocator, input: generate_mac.GenerateMacInput, options: generate_mac.Options) !generate_mac.GenerateMacOutput {
        return generate_mac.execute(self, allocator, input, options);
    }

    /// Generates an issuer script mac for EMV payment cards that use offline PINs
    /// as the cardholder verification method (CVM).
    ///
    /// This operation generates an authenticated issuer script response by
    /// appending the incoming message data (APDU command) with the target encrypted
    /// PIN block in ISO2 format. The command structure and method to send the
    /// issuer script update to the card is not defined by this operation and is
    /// typically determined by the applicable payment card scheme.
    ///
    /// The primary inputs to this operation include the incoming new encrypted
    /// pinblock, PIN encryption key (PEK), issuer master key (IMK), primary account
    /// number (PAN), and the payment card derivation method.
    ///
    /// The operation uses two issuer master keys - secure messaging for
    /// confidentiality (IMK-SMC) and secure messaging for integrity (IMK-SMI). The
    /// SMC key is used to internally derive a key to secure the pin, while SMI key
    /// is used to internally derive a key to authenticate the script reponse as per
    /// the [EMV 4.4 - Book 2 - Security and Key
    /// Management](https://www.emvco.com/specifications/) specification.
    ///
    /// This operation supports Amex, EMV2000, EMVCommon, Mastercard and Visa
    /// derivation methods, each requiring specific input parameters. Users must
    /// follow the specific derivation method and input parameters defined by the
    /// respective payment card scheme.
    ///
    /// Use GenerateMac operation when sending a script update to an EMV card that
    /// does not involve PIN change. When assigning IAM permissions, it is important
    /// to understand that EncryptData using EMV keys and GenerateMac perform
    /// similar functions to this command.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * EncryptData
    /// * GenerateMac
    pub fn generateMacEmvPinChange(self: *Self, allocator: std.mem.Allocator, input: generate_mac_emv_pin_change.GenerateMacEmvPinChangeInput, options: generate_mac_emv_pin_change.Options) !generate_mac_emv_pin_change.GenerateMacEmvPinChangeOutput {
        return generate_mac_emv_pin_change.execute(self, allocator, input, options);
    }

    /// Generates pin-related data such as PIN, PIN Verification Value (PVV), PIN
    /// Block, and PIN Offset during new card issuance or reissuance. For more
    /// information, see [Generate PIN
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/generate-pin-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// PIN data is never transmitted in clear to or from Amazon Web Services
    /// Payment Cryptography. This operation generates PIN, PVV, or PIN Offset and
    /// then encrypts it using Pin Encryption Key (PEK) to create an
    /// `EncryptedPinBlock` for transmission from Amazon Web Services Payment
    /// Cryptography. This operation uses a separate Pin Verification Key (PVK) for
    /// VISA PVV generation.
    ///
    /// Using ECDH key exchange, you can receive cardholder selectable PINs into
    /// Amazon Web Services Payment Cryptography. The ECDH derived key protects the
    /// incoming PIN block. You can also use it for reveal PIN, wherein the
    /// generated PIN block is protected by the ECDH derived key before transmission
    /// from Amazon Web Services Payment Cryptography. For more information on
    /// establishing ECDH derived keys, see the [Generating
    /// keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/create-keys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * GenerateCardValidationData
    /// * TranslatePinData
    /// * VerifyPinData
    pub fn generatePinData(self: *Self, allocator: std.mem.Allocator, input: generate_pin_data.GeneratePinDataInput, options: generate_pin_data.Options) !generate_pin_data.GeneratePinDataOutput {
        return generate_pin_data.execute(self, allocator, input, options);
    }

    /// Re-encrypt ciphertext using DUKPT or Symmetric data encryption keys.
    ///
    /// You can either generate an encryption key within Amazon Web Services Payment
    /// Cryptography by calling
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html) or import your own encryption key by calling [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html). The `KeyArn` for use with this operation must be in a compatible key state with `KeyModesOfUse` set to `Encrypt`.
    ///
    /// This operation also supports dynamic keys, allowing you to pass a dynamic
    /// encryption key as a TR-31 WrappedKeyBlock. This can be used when key
    /// material is frequently rotated, such as during every card transaction, and
    /// there is need to avoid importing short-lived keys into Amazon Web Services
    /// Payment Cryptography. To re-encrypt using dynamic keys, the `keyARN` is the
    /// Key Encryption Key (KEK) of the TR-31 wrapped encryption key material. The
    /// incoming wrapped key shall have a key purpose of D0 with a mode of use of B
    /// or D. For more information, see [Using Dynamic
    /// Keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/use-cases-acquirers-dynamickeys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// For symmetric and DUKPT encryption, Amazon Web Services Payment Cryptography
    /// supports `TDES` and `AES` algorithms. To encrypt using DUKPT, a DUKPT key
    /// must already exist within your account with `KeyModesOfUse` set to
    /// `DeriveKey` or a new DUKPT can be generated by calling
    /// [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html).
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * DecryptData
    /// * EncryptData
    /// *
    ///   [GetPublicCertificate](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetPublicKeyCertificate.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    pub fn reEncryptData(self: *Self, allocator: std.mem.Allocator, input: re_encrypt_data.ReEncryptDataInput, options: re_encrypt_data.Options) !re_encrypt_data.ReEncryptDataOutput {
        return re_encrypt_data.execute(self, allocator, input, options);
    }

    /// Translates an cryptographic key between different wrapping keys without
    /// importing the key into Amazon Web Services Payment Cryptography.
    ///
    /// This operation can be used when key material is frequently rotated, such as
    /// during every card transaction, and there is a need to avoid importing
    /// short-lived keys into Amazon Web Services Payment Cryptography. It
    /// translates short-lived transaction keys such as
    /// [PEK](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/terminology.html#terms.pek) generated for each transaction and wrapped with an [ECDH](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/terminology.html#terms.ecdh) derived wrapping key to another [KEK](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/terminology.html#terms.kek) wrapping key.
    ///
    /// Before using this operation, you must first request the public key
    /// certificate of the ECC key pair generated within Amazon Web Services Payment
    /// Cryptography to establish an ECDH key agreement. In `TranslateKeyData`, the
    /// service uses its own ECC key pair, public certificate of receiving ECC key
    /// pair, and the key derivation parameters to generate a derived key. The
    /// service uses this derived key to unwrap the incoming transaction key
    /// received as a TR31WrappedKeyBlock and re-wrap using a user provided KEK to
    /// generate an outgoing Tr31WrappedKeyBlock.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// *
    ///   [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html)
    /// *
    ///   [GetPublicCertificate](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetPublicKeyCertificate.html)
    /// *
    ///   [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html)
    pub fn translateKeyMaterial(self: *Self, allocator: std.mem.Allocator, input: translate_key_material.TranslateKeyMaterialInput, options: translate_key_material.Options) !translate_key_material.TranslateKeyMaterialOutput {
        return translate_key_material.execute(self, allocator, input, options);
    }

    /// Translates encrypted PIN block from and to ISO 9564 formats 0,1,3,4. For
    /// more information, see [Translate PIN
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/translate-pin-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// PIN block translation involves changing a PIN block from one encryption key
    /// to another and optionally change its format. PIN block translation occurs
    /// entirely within the HSM boundary and PIN data never enters or leaves Amazon
    /// Web Services Payment Cryptography in clear text. The encryption key
    /// transformation can be from PEK (Pin Encryption Key) to BDK (Base Derivation
    /// Key) for DUKPT or from BDK for DUKPT to PEK.
    ///
    /// Amazon Web Services Payment Cryptography also supports use of dynamic keys
    /// and ECDH (Elliptic Curve Diffie-Hellman) based key exchange for this
    /// operation.
    ///
    /// Dynamic keys allow you to pass a PEK as a TR-31 WrappedKeyBlock. They can be
    /// used when key material is frequently rotated, such as during every card
    /// transaction, and there is need to avoid importing short-lived keys into
    /// Amazon Web Services Payment Cryptography. To translate PIN block using
    /// dynamic keys, the `keyARN` is the Key Encryption Key (KEK) of the TR-31
    /// wrapped PEK. The incoming wrapped key shall have a key purpose of P0 with a
    /// mode of use of B or D. For more information, see [Using Dynamic
    /// Keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/use-cases-acquirers-dynamickeys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// Using ECDH key exchange, you can receive cardholder selectable PINs into
    /// Amazon Web Services Payment Cryptography. The ECDH derived key protects the
    /// incoming PIN block, which is translated to a PEK encrypted PIN block for use
    /// within the service. You can also use ECDH for reveal PIN, wherein the
    /// service translates the PIN block from PEK to a ECDH derived encryption key.
    /// For more information on establishing ECDH derived keys, see the [Creating
    /// keys](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/create-keys.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// The allowed combinations of PIN block format translations are guided by PCI.
    /// It is important to note that not all encrypted PIN block formats (example,
    /// format 1) require PAN (Primary Account Number) as input. And as such, PIN
    /// block format that requires PAN (example, formats 0,3,4) cannot be translated
    /// to a format (format 1) that does not require a PAN for generation.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// Amazon Web Services Payment Cryptography currently supports ISO PIN block 4
    /// translation for PIN block built using legacy PAN length. That is, PAN is the
    /// right most 12 digits excluding the check digits.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * GeneratePinData
    /// * VerifyPinData
    pub fn translatePinData(self: *Self, allocator: std.mem.Allocator, input: translate_pin_data.TranslatePinDataInput, options: translate_pin_data.Options) !translate_pin_data.TranslatePinDataOutput {
        return translate_pin_data.execute(self, allocator, input, options);
    }

    /// Verifies Authorization Request Cryptogram (ARQC) for a EMV chip payment card
    /// authorization. For more information, see [Verify auth request
    /// cryptogram](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/data-operations.verifyauthrequestcryptogram.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// ARQC generation is done outside of Amazon Web Services Payment Cryptography
    /// and is typically generated on a point of sale terminal for an EMV chip card
    /// to obtain payment authorization during transaction time. For ARQC
    /// verification, you must first import the ARQC generated outside of Amazon Web
    /// Services Payment Cryptography by calling
    /// [ImportKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_ImportKey.html). This operation uses the imported ARQC and an major encryption key (DUKPT) created by calling [CreateKey](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_CreateKey.html) to either provide a boolean ARQC verification result or provide an APRC (Authorization Response Cryptogram) response using Method 1 or Method 2. The `ARPC_METHOD_1` uses `AuthResponseCode` to generate ARPC and `ARPC_METHOD_2` uses `CardStatusUpdate` to generate ARPC.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * VerifyCardValidationData
    /// * VerifyPinData
    pub fn verifyAuthRequestCryptogram(self: *Self, allocator: std.mem.Allocator, input: verify_auth_request_cryptogram.VerifyAuthRequestCryptogramInput, options: verify_auth_request_cryptogram.Options) !verify_auth_request_cryptogram.VerifyAuthRequestCryptogramOutput {
        return verify_auth_request_cryptogram.execute(self, allocator, input, options);
    }

    /// Verifies card-related validation data using algorithms such as Card
    /// Verification Values (CVV/CVV2), Dynamic Card Verification Values
    /// (dCVV/dCVV2) and Card Security Codes (CSC). For more information, see
    /// [Verify card
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/verify-card-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// This operation validates the CVV or CSC codes that is printed on a payment
    /// credit or debit card during card payment transaction. The input values are
    /// typically provided as part of an inbound transaction to an issuer or
    /// supporting platform partner. Amazon Web Services Payment Cryptography uses
    /// CVV or CSC, PAN (Primary Account Number) and expiration date of the card to
    /// check its validity during transaction processing. In this operation, the CVK
    /// (Card Verification Key) encryption key for use with card data verification
    /// is same as the one in used for GenerateCardValidationData.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * GenerateCardValidationData
    /// * VerifyAuthRequestCryptogram
    /// * VerifyPinData
    pub fn verifyCardValidationData(self: *Self, allocator: std.mem.Allocator, input: verify_card_validation_data.VerifyCardValidationDataInput, options: verify_card_validation_data.Options) !verify_card_validation_data.VerifyCardValidationDataOutput {
        return verify_card_validation_data.execute(self, allocator, input, options);
    }

    /// Verifies a Message Authentication Code (MAC).
    ///
    /// You can use this operation to verify MAC for message data authentication
    /// such as . In this operation, you must use the same message data, secret
    /// encryption key and MAC algorithm that was used to generate MAC. You can use
    /// this operation to verify a DUPKT, CMAC, HMAC or EMV MAC by setting
    /// generation attributes and algorithm to the associated values.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * GenerateMac
    pub fn verifyMac(self: *Self, allocator: std.mem.Allocator, input: verify_mac.VerifyMacInput, options: verify_mac.Options) !verify_mac.VerifyMacOutput {
        return verify_mac.execute(self, allocator, input, options);
    }

    /// Verifies pin-related data such as PIN and PIN Offset using algorithms
    /// including VISA PVV and IBM3624. For more information, see [Verify PIN
    /// data](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/verify-pin-data.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// This operation verifies PIN data for user payment card. A card holder PIN
    /// data is never transmitted in clear to or from Amazon Web Services Payment
    /// Cryptography. This operation uses PIN Verification Key (PVK) for PIN or PIN
    /// Offset generation and then encrypts it using PIN Encryption Key (PEK) to
    /// create an `EncryptedPinBlock` for transmission from Amazon Web Services
    /// Payment Cryptography.
    ///
    /// For information about valid keys for this operation, see [Understanding key
    /// attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html) and [Key types for specific data operations](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/crypto-ops-validkeys-ops.html) in the *Amazon Web Services Payment Cryptography User Guide*.
    ///
    /// **Cross-account use**: This operation can't be used across different Amazon
    /// Web Services accounts.
    ///
    /// **Related operations:**
    ///
    /// * GeneratePinData
    /// * TranslatePinData
    pub fn verifyPinData(self: *Self, allocator: std.mem.Allocator, input: verify_pin_data.VerifyPinDataInput, options: verify_pin_data.Options) !verify_pin_data.VerifyPinDataOutput {
        return verify_pin_data.execute(self, allocator, input, options);
    }
};
