fn main() {
    let immutable_var: felt252 = 17;
    let mut mutable_var: felt252= 38;
    assert(mutable_var !=immutable_var,'mutable equals immutable');
}
fn test_main(){
    main();
}