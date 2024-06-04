function encodeImageToBase64(imagePath, callback) {
    const fs = require('fs');

    fs.readFile(imagePath, (err, data) => {
        if (err) throw err;
        const base64Image = data.toString('base64');
        callback(base64Image);
    });
}

// דוגמה לשימוש
const imagePath = 'path_to_your_image.jpg';
encodeImageToBase64(imagePath, (base64Image) => {
    console.log(base64Image);//ישלח לבלוקציין
});