import { Form } from "react-bootstrap";

function CustomFormGroup({
  title,
  value,
  setValue,
  type = "text",
  disabled = false,
  styleForm = {},
  styleLabel = {},
  styleControl = {},
}) {
  return (
    <Form.Group
      controlId={title}
      style={{
        display: "flex",
        // justifyContent: "space-evenly",
        textAlign: "left",
        alignItems: "center",
        margin: "20px 0px",
        ...styleForm,
      }}
    >
      <Form.Label
        style={{
          textAlign: "left",
          display: "inline-block",
          marginRight: "30px",
          width: "200px",
          ...styleLabel,
        }}
      >
        {`${title}:`}
      </Form.Label>
      <Form.Control
        style={{
          display: "inline-block",
          height: "35px",
          width: "100%",
          borderRadius: "4px",
          padding: "5px",
          minWidth: "150px",
          backgroundColor: "rgba(255,255,255,0.9)",
          ...styleControl,
        }}
        type={type}
        value={value}
        onChange={(event) => {
          if (setValue != null) setValue(event.target.value);
        }}
        placeholder={`Vui lòng nhập ${title}`}
        disabled={disabled}
      />
    </Form.Group>
  );
}
export default CustomFormGroup;
