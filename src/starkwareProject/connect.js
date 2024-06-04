const { starknet } = require('starknet');

// ציין את הכתובת של החוזה החכם שלך
const contractAddress = 'YOUR_CONTRACT_ADDRESS';

// פונקציה לשליחת מידע לחוזה החכם
async function sendDataToCairo(encodedImage) {
    const provider = new starknet.Provider({ baseUrl: 'https://alpha4.starknet.io' });
    const contract = new starknet.Contract(contractAbi, contractAddress, provider);

    const tx = await contract.functions.store_data(encodedImage).send();
    console.log('Transaction:', tx);
}

// קריאה לפונקציה עם המידע המקודד
encodeImageToBase64(imagePath, async (base64Image) => {
    await sendDataToCairo(base64Image);
});