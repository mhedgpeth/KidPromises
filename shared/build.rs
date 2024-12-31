fn main() {
    println!("cargo:rerun-if-changed=src/shared.udl");

    if let Err(e) = uniffi::generate_scaffolding("./src/shared.udl") {
        println!("cargo:warning=Failed to generate UniFFI scaffolding: {}", e);
        std::process::exit(1);
    }
}
